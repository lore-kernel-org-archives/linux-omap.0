From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 09/10] crypto: add timeout to crypto_wait_req
Date: Thu, 17 Oct 2019 15:25:48 +0300
Message-ID: <20191017122549.4634-10-t-kristo@ti.com>
References: <20191017122549.4634-1-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20191017122549.4634-1-t-kristo@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: herbert@gondor.apana.org.au, davem@davemloft.net, linux-crypto@vger.kernel.org, ard.biesheuvel@linaro.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Currently crypto_wait_req waits indefinitely for an async crypto request
to complete. This is bad as it can cause for example the crypto test
manager to hang without any notification as to why it has happened.
Instead of waiting indefinitely, add a 1 second timeout to the call,
and provide a warning print if a timeout happens.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 include/linux/crypto.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/linux/crypto.h b/include/linux/crypto.h
index 19ea3a371d7b..b8f0e5c3cc0c 100644
--- a/include/linux/crypto.h
+++ b/include/linux/crypto.h
@@ -682,8 +682,15 @@ static inline int crypto_wait_req(int err, struct crypto_wait *wait)
 	switch (err) {
 	case -EINPROGRESS:
 	case -EBUSY:
-		wait_for_completion(&wait->completion);
+		err = wait_for_completion_timeout(&wait->completion,
+						  msecs_to_jiffies(1000));
 		reinit_completion(&wait->completion);
+		if (!err) {
+			pr_err("%s: timeout for %p\n", __func__, wait);
+			err = -ETIMEDOUT;
+			break;
+		}
+
 		err = wait->err;
 		break;
 	};
-- 
2.17.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
