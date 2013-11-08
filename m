From: Joel Fernandes <joelf@ti.com>
Subject: Re: [PATCH v5] ARM: omap: edma: add suspend suspend/resume hooks
Date: Fri, 8 Nov 2013 10:14:30 -0600
Message-ID: <527D0DE6.6090506@ti.com>
References: <1383863549-7438-1-git-send-email-zonque@gmail.com>
 <87siv7pxpp.fsf@linaro.org> <527C6F70.1010103@ti.com>
 <CAGa+x85W_N9FCYu=dWTG8OgURr9Fo6oZ2KpW_XY9j_xZr8bBrg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAGa+x85W_N9FCYu=dWTG8OgURr9Fo6oZ2KpW_XY9j_xZr8bBrg@mail.gmail.com>
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
Cc: Nishanth Menon <nm@ti.com>, balajitk@ti.com, s.neumann@raumfeld.com, Sekhar Nori <nsekhar@ti.com>, Gururaja Hebbar <gururaja.hebbar@ti.com>, Daniel Mack <zonque@gmail.com>, Russ Dill <Russ.Dill@ti.com>, Vaibhav Bedia <vaibhav.bedia@gmail.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On 11/08/2013 12:28 AM, Kevin Hilman wrote:
[..]
>>> Also, I believe it was already suggested by Nishanth, but the late/early
>>> callbacks are probably more appropriate here than the noirq callbacks.
>>> Unless there's a *really* good reason to use the noirq callbacks, they
>>> should be avoided.
>>>
>>> That being said, I wonder if the whole approach here is the right one.
>>> I know you're basing your stuff on some TI tree, but that doesn't make
>>> it the right way (usually, it's the opposite, but I digress...)  ;)
>>>
>>> IMO, EDMA should be done like we currently do I2C and not implement
>>> suspend/resume at all.  Instead, the driver should do runtime PM done on
>>
>> But a potential problem with this is powering edma on or off between xfers may
>> slow things down quite a bit because xfers happen so much often and there is
>> some overhead in the pm_runtime calls which adds up overtime when dealing with
>> something as frequent as EDMA. Also we would lose the global EDMA context right
>> so we'd have to restore the context every time during runtime PM (?).
> 
> Have a look at the autosuspend feature of runtime PM.  (c.f.
> Documentation/power/pm_runtime.txt)

Sure, will do that. Thanks :)

Just one more silly question, in very frequent operations is there no over-head
even when using autosuspend? Because when I traced last time (without
autosuspend), the depth of pm runtime calls were quite a lot but this could also
be because of the OMAP implementation.

>> I had a patch that also made AES driver not pm_runtime_get/put specially when
>> the next crypto request was imminent. But instead adopted a softer approach
>> where the pm_runtime_put call would happen at a time when we are sure we're at
>> the end of all requests. This resulted in quite a speed up.
> 
> Sounds like you partially re-invented autosuspend.

Hehe. :)

regards,

-Joel
