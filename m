From: Joel Fernandes <joelf@ti.com>
Subject: Re: [PATCH v5] ARM: omap: edma: add suspend suspend/resume hooks
Date: Thu, 7 Nov 2013 22:58:24 -0600
Message-ID: <527C6F70.1010103@ti.com>
References: <1383863549-7438-1-git-send-email-zonque@gmail.com>
 <87siv7pxpp.fsf@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <87siv7pxpp.fsf@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kevin Hilman <khilman@linaro.org>
Cc: nm@ti.com, balajitk@ti.com, s.neumann@raumfeld.com, nsekhar@ti.com, gururaja.hebbar@ti.com, Daniel Mack <zonque@gmail.com>, Russ.Dill@ti.com, vaibhav.bedia@gmail.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Kevin,

On 11/07/2013 06:02 PM, Kevin Hilman wrote:
> Daniel Mack <zonque@gmail.com> writes:
[..]
>> +	.resume_noirq	= edma_pm_resume,
>> +};
> 
> Also, I believe it was already suggested by Nishanth, but the late/early
> callbacks are probably more appropriate here than the noirq callbacks.
> Unless there's a *really* good reason to use the noirq callbacks, they
> should be avoided.
> 
> That being said, I wonder if the whole approach here is the right one.
> I know you're basing your stuff on some TI tree, but that doesn't make
> it the right way (usually, it's the opposite, but I digress...)  ;)
> 
> IMO, EDMA should be done like we currently do I2C and not implement
> suspend/resume at all.  Instead, the driver should do runtime PM done on

But a potential problem with this is powering edma on or off between xfers may
slow things down quite a bit because xfers happen so much often and there is
some overhead in the pm_runtime calls which adds up overtime when dealing with
something as frequent as EDMA. Also we would lose the global EDMA context right
so we'd have to restore the context every time during runtime PM (?).

I had a patch that also made AES driver not pm_runtime_get/put specially when
the next crypto request was imminent. But instead adopted a softer approach
where the pm_runtime_put call would happen at a time when we are sure we're at
the end of all requests. This resulted in quite a speed up.

thanks,

-Joel
