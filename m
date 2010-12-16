From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 0/9] TI DMM-TILER driver
Date: Thu, 16 Dec 2010 14:34:05 +0100
Message-ID: <201012161434.05768.arnd@arndb.de>
References: <1291674446-10766-1-git-send-email-davidsin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org>
In-Reply-To: <1291674446-10766-1-git-send-email-davidsin@ti.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
	<mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org
Errors-To: dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org
To: linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org
Cc: David Sin <davidsin@ti.com>, Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-omap@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>
List-Id: linux-omap@vger.kernel.org

On Monday 06 December 2010, David Sin wrote:
> Tiling and Isometric Lightweight Engine for Rotation (TILER) driver
> =====
> 
> Dynamic Memory Manager (DMM) is a hardware block made by Texas Instruments.
> Within the DMM exists at least one TILER hardware component.  Its purpose is to
> organize video/image memory in a 2-dimensional fashion to limit memory
> bandwidth and facilitate 0 effort rotation and mirroring.  The TILER driver
> facilitates allocating, freeing, as well as mapping 2D blocks (areas) in the
> TILER container(s).  It also facilitates rotating and mirroring the allocated
> blocks or its rectangular subsections.

How does this relate to DRM/GEM? I don't understand too much about graphics
drivers, but it does sound like there is some overlap in functionality.

I guess at the very least the DMM should live in drivers/gpu/ instead of
drivers/misc, but perhaps it could be integrated more closely with the
existing code there.

	Arnd
