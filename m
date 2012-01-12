From: Felipe Contreras <felipe.contreras-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH RFC] OMAP: I2C: Fix the mismatch of pm_runtime enable and disable
Date: Thu, 12 Jan 2012 17:24:30 +0200
Message-ID: <CAMP44s3TUEU9rdc7m73yEDrUu=-TgesypiBg=iVtg+gXodSfYA@mail.gmail.com>
References: <1326288104-10544-1-git-send-email-shubhrajyoti@ti.com>
	<CANOLnONdYYybbSP143+TeLxjfdEg1krcZjHwf140Fm5Y8rHogA@mail.gmail.com>
	<4F0D9BE1.6070209@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4F0D9BE1.6070209-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Cc: Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, khilman-l0cyMroinI0@public.gmane.org, Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Jan 11, 2012 at 4:25 PM, Shubhrajyoti <shubhrajyoti-l0cyMroinI0@public.gmane.org> wro=
te:
> On Wednesday 11 January 2012 07:29 PM, Grazvydas Ignotas wrote:
>> On Wed, Jan 11, 2012 at 3:21 PM, Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org=
> wrote:
>>> Currently the i2c driver calls the pm_runtime_enable and never
>>> the disable. This may cause a warning when pm_runtime_enable
>>> checks for the count match.Attempting to fix the same by calling
>>> pm_runtime_disable in the error and the remove path.
>> I remember seeing Felipe doing the reverse to musb here:
>> http://marc.info/?l=3Dlinux-omap&m=3D132432610700952&w=3D2
>> so I'm confused here.
> Strange however =C2=A0I see many drivers doing the same in the kernel
> on greping . Besides I expect a warn to come up.
>
> Felipe could you explain the issue?

When do you see the warning? kfree(dev) should disable runtime pm, but
without waking up the device.

--=20
=46elipe Contreras
