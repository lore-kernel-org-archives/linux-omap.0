From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] staging: tidspbridge: remove file handling functions
 for loader
Date: Wed, 8 Dec 2010 14:26:42 -0800
Message-ID: <20101208222642.GA31802@kroah.com>
References: <1291702146-17866-1-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1291702146-17866-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Omar Ramirez Luna <omar.ramirez@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Ohad Ben-Cohen <ohad@wizery.com>, Nishanth Menon <nm@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>, Fernando Guzman Lugo <fernando.lugo@ti.com>, Armando Uribe De Leon <x0095078@ti.com>, Greg Kroah-Hartman <gregkh@suse.de>, Ernesto Ramos Falcon <ernesto@ti.com>, linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org, Rene Sapiens <rene.sapiens@ti.com>
List-Id: linux-omap@vger.kernel.org

On Tue, Dec 07, 2010 at 12:09:06AM -0600, Omar Ramirez Luna wrote:
> Instead use request_firmware and friends to get a valid firmware
> image.
> 
> Right now the image is supplied dynamically through udev and the
> following rule:
> 
> KERNEL=="omap-dsp", SUBSYSTEM=="firmware", ACTION=="add",	\
> 	RUN+="/bin/sh -c 'echo 1 > /sys/$DEVPATH/loading;	\
> 		cat $FIRMWARE > /sys/$DEVPATH/data;		\
> 		echo 0 > /sys/$DEVPATH/loading'"

Why do you need a custom firmware rule?  Why doesn't the default
firmware loading rule that comes with udev work properly for you?  What
are you needing different here that works properly for all other
drivers?

confused,

greg k-h
