From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] ARM: DTS: OMAP4: Add OMAP4 Blaze Tablet support
Date: Tue, 25 Jun 2013 23:27:26 -0700
Message-ID: <20130626062725.GL5523@atomide.com>
References: <1372159970-6361-1-git-send-email-ruslan.bilovol@ti.com>
 <51C9A412.1050802@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <51C9A412.1050802@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Murphy <dmurphy@ti.com>
Cc: Ruslan Bilovol <ruslan.bilovol@ti.com>, b-cousson@ti.com, benoit.cousson@linaro.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
List-Id: linux-omap@vger.kernel.org

* Dan Murphy <dmurphy@ti.com> [130625 07:13]:
> On 06/25/2013 06:32 AM, Ruslan Bilovol wrote:
> >The OMAP4 Blaze Tablet is TI OMAP4 processor-based
> >development platform in a tablet formfactor.
> >The platform contains many of the features found in
> >present-day handsets (such as audio, video, wireless
> >functions and user interfaces) and in addition
> >contains features for software development and test.
> Why do we want to send this upstream?
> What is the advantage to having this supported?
> 
> I don't believe we need to add another community board.  We have a
> SDP and Panda.

Why not? Just the .dts file is needed nowadays and it
may make it easier to support various other omap4 based
tablets that have similar features.

Regards,

Tony
