From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] ARM: add get_user() support for 8 byte types
Date: Mon, 12 Nov 2012 19:27:27 +0000
Message-ID: <20121112192727.GB28341@n2100.arm.linux.org.uk>
References: <1352495853-9790-1-git-send-email-rob.clark@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1352495853-9790-1-git-send-email-rob.clark@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Clark <rob.clark@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, patches@linaro.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org, Arnd Bergmann <arnd@arndb.de>, Rob Clark <rob@ti.com>
List-Id: linux-omap@vger.kernel.org

On Fri, Nov 09, 2012 at 03:17:33PM -0600, Rob Clark wrote:
> From: Rob Clark <rob@ti.com>
> 
> A new atomic modeset/pageflip ioctl being developed in DRM requires
> get_user() to work for 64bit types (in addition to just put_user()).

NAK.

(I did write a better email explaining all the ins and outs of why this
won't work and why 64-bit get_user isn't possible, but my editor crapped
out and lost all that well written message; I don't fancy typing it all
out again.)

Nevertheless,
int test_ptr(unsigned int **v, unsigned int **p)
{
        return get_user(*v, p);
}

produces a warning, and you can't get away from that if you stick 64-bit
support into get_user().

Sorry, 64-bit get_user() is a no-no.
