From: David Brownell <david-b@pacbell.net>
Subject: Re: [REVIEW PATCH 2/2] Added OMAP3EVM Multi-Media Daughter Card Support
Date: Sun, 11 Jan 2009 15:54:10 -0800
Message-ID: <200901111554.10469.david-b@pacbell.net>
References: <hvaibhav@ti.com> <1231308470-31159-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <1231308470-31159-1-git-send-email-hvaibhav@ti.com>
Content-Disposition: inline
Sender: linux-media-owner@vger.kernel.org
To: hvaibhav@ti.com
Cc: linux-omap@vger.kernel.org, linux-media@vger.kernel.org, video4linux-list@redhat.com, Brijesh Jadav <brijesh.j@ti.com>, Hardik Shah <hardik.shah@ti.com>, Manjunath Hadli <mrh@ti.com>, R Sivaraj <sivaraj@ti.com>
List-Id: linux-omap@vger.kernel.org

On Tuesday 06 January 2009, hvaibhav@ti.com wrote:
> +config MACH_OMAP3EVM_DC
> +=A0=A0=A0=A0=A0=A0=A0bool "OMAP 3530 EVM daughter card board"
> +=A0=A0=A0=A0=A0=A0=A0depends on ARCH_OMAP3 && ARCH_OMAP34XX && MACH_=
OMAP3EVM

There can be other daughtercards, so the Kconfig text should
say which specific card is being configured.  And it should
probably use the "zero or one of these choices" syntax, so
it's easier to include other options..

- Dave


--
To unsubscribe from this list: send the line "unsubscribe linux-media" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
