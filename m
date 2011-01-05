From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH v3 08/17] OMAP2,3: DSS2: Create platform_driver for
 each DSS HW IP
Date: Wed, 05 Jan 2011 16:58:24 +0200
Message-ID: <1294239504.14254.126.camel@tubuntu>
References: <1294059069-26737-1-git-send-email-svadivu@ti.com>
	 <1294059069-26737-9-git-send-email-svadivu@ti.com>
	 <1294226823.14254.51.camel@tubuntu>
	 <AANLkTikCUbyqwyhnqF9UDF2Nc9q6-EJqAaeHfjSkiwxM@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mgw-da02.ext.nokia.com ([147.243.128.26]:51120 "EHLO
	mgw-da02.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751662Ab1AEO6c (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Jan 2011 09:58:32 -0500
In-Reply-To: <AANLkTikCUbyqwyhnqF9UDF2Nc9q6-EJqAaeHfjSkiwxM@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Semwal, Sumit" <sumit.semwal@ti.com>
Cc: ext Guruswamy Senthilvadivu <svadivu@ti.com>, paul@pwsan.com, khilman@deeprootsystems.com, a0919096@ti.com, linux-omap@vger.kernel.org, "Hiremath, Vaibhav" <hvaibhav@ti.com>

On Wed, 2011-01-05 at 18:55 +0530, ext Semwal, Sumit wrote:
> Hi Tomi,
> 
> On Wed, Jan 5, 2011 at 4:57 PM, Tomi Valkeinen <tomi.valkeinen@nokia.com> wrote:
> > Hi,

> >
> > Does this even work if the DSS is compiled as a module? I have the
> > recollection that a module can only have one initcall, and in this case
> > omapdss would have many.
> 
> [Sumit]: we haven't tried compiling DSS as module - I guess we will
> have to create each dss hw IP also as a separate module.

Having them as separate modules makes things quite complex: then you
need to be able to load only the modules you want (eg. leave dsi.ko
out). But you'd also need to be able to load the dsi.ko later, after you
decide to use a dsi based panel.

This would of course be very neat, but I don't believe it's a very easy
task. For the time being I would keep the DSS as one module, and if
needed, try dividing it into separate modules later as a separate task.

> About making one common initcall, then I think we would need to have
> all platform_driver related functions either as global or in one file.
> is this a better option than having each as a separate module?

I'd say it's better in the sense that a) it would work and b) it would
be much easier than dividing DSS into multiple modules.

I'd say have the platform driver code in their respective files (dsi.c,
venc.c etc), and call dsi_init_platform_driver() from the probe
function. That would keep the code clean if we decide to split the DSS
into multiple modules.

Also, shouldn't there be platform_driver_unregister() calls somewhere?
You should definitely also test with DSS as a module =).

 Tomi


