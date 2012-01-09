From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: USB Host port inoperative after kexec on Beagleboard
Date: Mon, 9 Jan 2012 22:54:03 +0000
Message-ID: <20120109225403.GB23090@mudshark.cambridge.arm.com>
References: <w4wr90wmrx.wl%peter@chubb.wattle.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kexec-bounces+glkk-kexec=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <w4wr90wmrx.wl%peter-LkDQP0DxSMGxwJ88Py/mJxCuuivNXqWP@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:kexec-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: kexec-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Errors-To: kexec-bounces+glkk-kexec=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Peter Chubb <peter.chubb-3w/jM7ZMsnj0CCvOHzKKcA@public.gmane.org>
Cc: "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Jan 09, 2012 at 10:09:54PM +0000, Peter Chubb wrote:
> 
> Hi Will,

Hi Peter [adding linux-arm-kernel],

>    Thanks for the fixes to kexec for ARM that went into mainline this
>    week.  Mostly things work now.

Great, that's good to hear!

>    One issue: the USB EHCI port on the (rev C2) beagleboard doesn't
>    work after a kexec.  During boot after kexec, the host device is
>    detected and initialised, but nothing plugged in works, even when
>    everything was working corectly before the kexec.  Das U-boot
>    must set up something that is then undone during the kexec reboot.

Ouch. Have you had a chance to look at the u-boot sources to see what it
does?

>    I've traced all calls to clk_enable() and clk_disable(), and
>    everything looks all right --- in particular I can't see 
>    anything explicitly disabled during kexec that isn't reenabled
>    during boot of the subsequent kernel.
> 
>    Voltages that I can measure look correct on the port.
> 
>    Do you have any suggestions as to what else could be wrong?

I'm afraid I'm not familiar with the Beagleboard, so I can't begin to guess.
Have you tried re-initialising the host controller in the new kernel
manually (perhaps my building the driver as a module and {un}loading it a
few times?). It could be that some hardware state persists across the kexec
and it just needs resetting.

Will
