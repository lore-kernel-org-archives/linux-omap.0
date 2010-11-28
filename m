From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC/PATCH v6 05/12] media: Reference count and power handling
Date: Sun, 28 Nov 2010 18:25:39 +0000
Message-ID: <6C806F24-FF45-4BF6-ACB0-1EE10AC584BD@opensource.wolfsonmicro.com>
References: <1290652099-15102-1-git-send-email-laurent.pinchart@ideasonboard.com> <4CEEA191.1000706@maxwell.research.nokia.com> <20101125214633.GC25162@opensource.wolfsonmicro.com> <201011281333.39214.laurent.pinchart@ideasonboard.com> (sfid-20101128_154847_234366_292E6E7B)
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201011281333.39214.laurent.pinchart@ideasonboard.com> (sfid-20101128_154847_234366_292E6E7B)
Sender: linux-kernel-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Sakari Ailus <sakari.ailus@maxwell.research.nokia.com>, linux-media@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, lrg@slimlogic.co.uk, lennart@poettering.net
List-Id: linux-omap@vger.kernel.org

On 28 Nov 2010, at 12:33, Laurent Pinchart wrote:

> Throwing an idea here, what about making power management modular ? The MC 
> core would then call back to drivers to handle use count changes. The 
> media_entity_use_change() function would be exported (and renamed), so that 
> drivers could use it if they want graph-based power management. ALSA would 
> have its own use count handler.

We need more than just the count handler - we need a complete list of everything that has been changed in the whole system. The graph walk itself is fine but we need to be able to do postprocessing of the delta that is generated. Like I said pre- and post- callbacks may well cover it.

Note that this is specifically for ASoC, not ALSA in general.