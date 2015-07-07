From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH v2 5/7] crypto: aead: Add aead_request_cast() api
Date: Tue, 7 Jul 2015 21:01:47 +0530
Message-ID: <1436283109-13318-6-git-send-email-lokeshvutla@ti.com>
References: <1436283109-13318-1-git-send-email-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-crypto-owner@vger.kernel.org>
In-Reply-To: <1436283109-13318-1-git-send-email-lokeshvutla@ti.com>
Sender: linux-crypto-owner@vger.kernel.org
To: herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org, davem@davemloft.net
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, t-kristo@ti.com, nsekhar@ti.com, lokeshvutla@ti.com
List-Id: linux-omap@vger.kernel.org

Add aead_request_cast() api to get pointer to aead_request
from cryto_async_request.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
 include/crypto/internal/aead.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/crypto/internal/aead.h b/include/crypto/internal/aead.h
index 4b25471..0423fa5 100644
--- a/include/crypto/internal/aead.h
+++ b/include/crypto/internal/aead.h
@@ -157,6 +157,12 @@ static inline unsigned int crypto_aead_maxauthsize(struct crypto_aead *aead)
 	return crypto_aead_alg_maxauthsize(crypto_aead_alg(aead));
 }
 
+static inline struct aead_request *aead_request_cast(
+					struct crypto_async_request *req)
+{
+	return container_of(req, struct aead_request, base);
+}
+
 int crypto_register_aead(struct aead_alg *alg);
 void crypto_unregister_aead(struct aead_alg *alg);
 int crypto_register_aeads(struct aead_alg *algs, int count);
-- 
1.9.1
