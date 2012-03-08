From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 0/8] Add TI EMIF SDRAM controller driver
Date: Thu, 8 Mar 2012 14:47:38 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1203081443030.9551@utopia.booyaka.com>
References: <1331222065-3579-1-git-send-email-aneesh@ti.com> <20120308205944.GB16644@kroah.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120308205944.GB16644@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Aneesh V <aneesh@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thu, 8 Mar 2012, Greg KH wrote:

> On Thu, Mar 08, 2012 at 09:24:17PM +0530, Aneesh V wrote:
>
> > The driver will need some minor updates when it is eventually
> > integrated with Dynamic Voltage and Frequency Scaling (DVFS).
> > This can not be done now as DVFS support is not available in
> > the mainline yet.
> 
> What will need to be updated in it?  The userspace interface or
> something else?
> 
> Why not wait until that code is accepted, it should be going into 3.4,
> right?

DVFS for the ARM cores is going in for 3.4 - that's not what Aneesh is 
referring to.  The changes here pertain to DVFS for core devices.  Core 
devices include the EMIF as well as several other devices.  Core DVFS is 
much more challenging to implement cleanly.  It has clock framework and 
driver dependencies.  So it probably won't be ready for several months at 
the very least.


- Paul
