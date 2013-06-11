From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH 10/22] mfd/ti_am335x_tscadc: Add DT support
Date: Tue, 11 Jun 2013 16:23:47 +0200
Message-ID: <20130611142347.GF29135@zurbaran>
References: <1370950268-7224-1-git-send-email-bigeasy@linutronix.de>
 <1370950268-7224-11-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1370950268-7224-11-git-send-email-bigeasy@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Lee Jones <lee.jones@linaro.org>, =?iso-8859-1?Q?Beno=EEt?= Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Jonathan Cameron <jic23@cam.ac.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Felipe Balbi <balbi@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-iio@vger.kernel.org, linux-input@vger.kernel.org, "Patil, Rachna" <rachna@ti.com>, Pantelis Antoniou <panto@antoniou-consulting.com>
List-Id: linux-omap@vger.kernel.org

Hi Sebastian,

On Tue, Jun 11, 2013 at 01:30:56PM +0200, Sebastian Andrzej Siewior wrote:
> From: "Patil, Rachna" <rachna@ti.com>
> 
> Make changes to add DT support in the MFD core driver.
Which changes ?


> [ panto@antoniou-consulting.com : use of_get_child_by_name
> 	instead of of_find_node_by_name ]
I have no idea where that is coming from. Please remove this kind of
stuff and build a proper commit log instead.


> Signed-off-by: Pantelis Antoniou <panto@antoniou-consulting.com>
> Signed-off-by: Patil, Rachna <rachna@ti.com>
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> [bigeasy: module alias, rename to ti,am3359-tscadc as it was tested on
>           AM3359]
I honestly can't tell if this is a change from the last version of your
patchset or a description of this patch changes in general.
This is cluttering your commit logs, please remove this as well.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
