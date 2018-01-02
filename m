From: Aishwarya Pant <aishpant@gmail.com>
Subject: Re: Documentation: OMAPDSS: move sysfs documentation to ABI
Date: Tue, 2 Jan 2018 16:26:21 +0530
Message-ID: <20180102105621.GB5645@mordor.localdomain>
References: <20180102085436.GA32637@mordor.localdomain>
 <3b9a14dd-ad04-e4ce-bc8f-dff7fa2a90cd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3b9a14dd-ad04-e4ce-bc8f-dff7fa2a90cd@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Jonathan Corbet <corbet@lwn.net>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Julia Lawall <Julia.Lawall@lip6.fr>, Greg KH <gregkh@linuxfoundation.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Jan 02, 2018 at 12:16:18PM +0200, Tomi Valkeinen wrote:
> Hi,
> 
> On 02/01/18 10:54, Aishwarya Pant wrote:
> > Hi
> > 
> > In Documentation/arm/OMAP/DSS, there is a description of the DSS and FB sysfs
> > interfaces which could be moved to Documentation/ABI.
> > 
> > Would such a change be useful? I can see that the sysfs interface is still in
> > testing.
> > 
> > The ABI documentation format looks like the following:
> > 
> > What:          (the full sysfs path of the attribute)
> > Date:          (date of creation)
> > KernelVersion: (kernel version it first showed up in)
> > Contact:       (primary contact)
> > Description:   (long description on usage)
> > 
> > I am doing this in an exercise to move sysfs ABI interfaces (which are
> > documented) to their right place i.e. in Documentation/ABI along with the rest.
> 
> The Documentation/arm/OMAP/DSS document is for omapfb driver, which is
> deprecated by the omapdrm driver. I haven't maintained omapfb for some
> time now, but I guess it still works ok. I hope we can drop omapfb at
> some point in the future.
> 
> There probably are still omapfb users out there, so the ABI is valid,
> but I'd say it's quite at the bottom of the priority list.

All right, I will drop this then.

> 
>  Tomi
> 
> -- 
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
