From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH 25/50] staging: omap-thermal: rewrite
 omap_bandgap_mcelsius_to_adc on kernel coding style
Date: Sat, 16 Mar 2013 11:33:07 +0300
Message-ID: <20130316083307.GN9138@mwanda>
References: <1363352438-15935-1-git-send-email-eduardo.valentin@ti.com>
 <1363352438-15935-26-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1363352438-15935-26-git-send-email-eduardo.valentin@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@ti.com>
Cc: gregkh@linuxfoundation.org, devel@driverdev.osuosl.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Fri, Mar 15, 2013 at 09:00:13AM -0400, Eduardo Valentin wrote:
> Follow Documentation/CodingStyle while doing omap_bandgap_mcelsius_to_adc
> 

I have the same response for all these bunny hop patches.

When you're reading the code and you see a goto then you assume that
it's there for a reason so it's misleading when it doesn't do
anything.  It's simpler if the code is simple.

regards,
dan carpenter
