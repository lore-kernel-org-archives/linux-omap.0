From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: am33xx: Fix syntax of alias names
Date: Tue, 3 Jul 2018 00:23:29 -0700
Message-ID: <20180703072329.GL112168@atomide.com>
References: <1528728353-5889-1-git-send-email-fb@ltec.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1528728353-5889-1-git-send-email-fb@ltec.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Felix Brack <fb@ltec.ch>
Cc: bcousson@baylibre.com, robh+dt@kernel.org, mark.rutland@arm.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Felix Brack <fb@ltec.ch> [180611 08:12]:
> DT specifications do not allow the underscore character in alias names.
> Replace all underscores in alias names by dashes.

Applying into omap-for-v4.19/dt thanks.

Tony
