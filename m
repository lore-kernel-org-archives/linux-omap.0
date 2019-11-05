From: Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH 09/10] crypto: add timeout to crypto_wait_req
Date: Tue, 5 Nov 2019 09:42:00 -0800
Message-ID: <20191105174200.GC757@sol.localdomain>
References: <20191017122549.4634-1-t-kristo@ti.com>
 <20191017122549.4634-10-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20191017122549.4634-10-t-kristo@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tero Kristo <t-kristo@ti.com>
Cc: herbert@gondor.apana.org.au, ard.biesheuvel@linaro.org, linux-crypto@vger.kernel.org, linux-omap@vger.kernel.org, davem@davemloft.net, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Thu, Oct 17, 2019 at 03:25:48PM +0300, Tero Kristo wrote:
> Currently crypto_wait_req waits indefinitely for an async crypto request
> to complete. This is bad as it can cause for example the crypto test
> manager to hang without any notification as to why it has happened.
> Instead of waiting indefinitely, add a 1 second timeout to the call,
> and provide a warning print if a timeout happens.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---
>  include/linux/crypto.h | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/crypto.h b/include/linux/crypto.h
> index 19ea3a371d7b..b8f0e5c3cc0c 100644
> --- a/include/linux/crypto.h
> +++ b/include/linux/crypto.h
> @@ -682,8 +682,15 @@ static inline int crypto_wait_req(int err, struct crypto_wait *wait)
>  	switch (err) {
>  	case -EINPROGRESS:
>  	case -EBUSY:
> -		wait_for_completion(&wait->completion);
> +		err = wait_for_completion_timeout(&wait->completion,
> +						  msecs_to_jiffies(1000));
>  		reinit_completion(&wait->completion);
> +		if (!err) {
> +			pr_err("%s: timeout for %p\n", __func__, wait);
> +			err = -ETIMEDOUT;
> +			break;
> +		}
> +
>  		err = wait->err;
>  		break;
>  	};

I'm not sure this is a good idea, because operations could legitimately take a
long time, e.g. if someone passes in a huge data buffer.  How do you know that X
amount of time is always going to be enough?

- Eric
