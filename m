From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH] Media controller: Define media_entity_init() and media_entity_cleanup() conditionally
Date: Thu, 18 Aug 2011 11:03:49 +0200
Message-ID: <201108181103.49805.laurent.pinchart@ideasonboard.com>
References: <1313577276-18182-1-git-send-email-deepthy.ravi@ti.com> <1313578426.25065.1.camel@smile>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <1313578426.25065.1.camel@smile>
Sender: linux-media-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Deepthy Ravi <deepthy.ravi@ti.com>, mchehab@infradead.org, linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Vaibhav Hiremath <hvaibhav@ti.com>
List-Id: linux-omap@vger.kernel.org

On Wednesday 17 August 2011 12:53:46 Andy Shevchenko wrote:
> On Wed, 2011-08-17 at 16:04 +0530, Deepthy Ravi wrote:
> > From: Vaibhav Hiremath <hvaibhav@ti.com>
> > 
> > Defines the two functions only when CONFIG_MEDIA_CONTROLLER
> > is enabled.
> 
> Is it not a driver's option to be dependent on MEDIA_CONTROLLER?

Yes it is.

-- 
Regards,

Laurent Pinchart
