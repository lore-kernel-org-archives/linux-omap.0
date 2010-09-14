From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH V3 1/2] input: CMA3000 Accelerometer driver
Date: Tue, 14 Sep 2010 01:00:03 -0700
Message-ID: <20100914080003.GD15167@core.coreip.homeip.net>
References: <61033.10.24.255.18.1283926671.squirrel@dbdmail.itg.ti.com>
 <4C877584.7000902@jic23.retrosnub.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4C877584.7000902@jic23.retrosnub.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonathan Cameron <kernel@jic23.retrosnub.co.uk>
Cc: Hemanth V <hemanthv@ti.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, Sep 08, 2010 at 12:37:40PM +0100, Jonathan Cameron wrote:
> 
> I'm happy to see your driver go in as it is currently, what bothers me is that we will end
> up with incompatible interfaces for all the accelerometers Dmitry takes!
> 

This is a valid concern. How about I chicken out and will not merge any
new sysfs knobs until you guys decide on reasonable interface? Most set
up is done by board code anyways, sysfs is more of nice-to-have?

-- 
Dmitry
