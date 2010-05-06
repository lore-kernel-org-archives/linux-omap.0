From: "Arce, Abraham" <x0066660@ti.com>
Subject: RE: [RFC] [PATCH 1/3] OMAP4: Keyboard Controller Support
Date: Wed, 5 May 2010 21:30:24 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A53043DEEC189@dlee03.ent.ti.com>
References: <27F9C60D11D683428E133F85D2BB4A53043D9EE7F5@dlee03.ent.ti.com>
 <87vdblbtqn.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <87vdblbtqn.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Thanks Kevin,

> > Keyboard controller for OMAP4 with built-in scanning algorithm.
> > The following implementations are used:
> >
> >   - matrix_keypac.c logic
> >   - hwmod framework
> >   - threaded irq
> >
> > Signed-off-by: Syed Rafiuddin <rafiuddin.syed@ti.com>
> > Signed-off-by: Abraham Arce <x0066660@ti.com>
> 
> Some general comments...
> 
> What's missing here is a separation of the driver and the device.
> What you need is for arch code to register a platfrom_device (using
> hwmod + omap_device).  Then this driver will use the standard
> platform_device resource calls to get its base address, IRQs, etc. and
> any platform_data.
> 
> IOW, as Felipe mentioned, the driver should not be doing the hwmod +
> omap_device init and registration.

As metioned to Felipe, my approach is 

  sdp4430_keypad_init() {
     ...
     omap_hwmod_lookup(oh_name);
     ...
     kzalloc(sizeof(struct matrix_keypad_platform_data), GFP_KERNEL);
     ...
     omap_device_build(name, id, oh, pdata,
     ...
  }

and then called within

  omap_4430sdp_init()


Best Regards
Abraham
