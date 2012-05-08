From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 08/10] arm: omap4panda: Add support for omap4iss
 camera
Date: Tue, 8 May 2012 16:46:41 -0700
Message-ID: <20120508234641.GV5088@atomide.com>
References: <1335971749-21258-1-git-send-email-saaguirre@ti.com>
 <1335971749-21258-9-git-send-email-saaguirre@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-media-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1335971749-21258-9-git-send-email-saaguirre@ti.com>
Sender: linux-media-owner@vger.kernel.org
To: Sergio Aguirre <saaguirre@ti.com>
Cc: linux-media@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Sergio Aguirre <saaguirre@ti.com> [120502 08:21]:
> This adds support for camera interface with the support for
> following sensors:
> 
> - OV5640
> - OV5650

It seems that at this point we should initialize new things like this
with DT only. We don't quite yet have the muxing in place, but I'd
rather not add yet another big platform_data file for something that
does not even need to be there for DT booted devices.

Regards,

Tony
