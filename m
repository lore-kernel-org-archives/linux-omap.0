From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [RFC/PATCH v6 02/12] media: Media device
Date: Thu, 25 Nov 2010 10:33:02 +0100
Message-ID: <4CEE2D4E.6070906@ladisch.de>
References: <1290652099-15102-1-git-send-email-laurent.pinchart@ideasonboard.com> <1290652099-15102-3-git-send-email-laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1290652099-15102-3-git-send-email-laurent.pinchart@ideasonboard.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-media@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, sakari.ailus@maxwell.research.nokia.com, broonie@opensource.wolfsonmicro.com, lennart@poettering.net
List-Id: linux-omap@vger.kernel.org

Laurent Pinchart wrote:
> +struct media_device {
> ...
> +	u8 model[32];
> +	u8 serial[40];
> +	u8 bus_info[32];

All drivers and userspace applications have to treat this as char[], so
why u8[]?


Regards,
Clemens
