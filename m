From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] Media controller: Define media_entity_init() and
 media_entity_cleanup() conditionally
Date: Wed, 17 Aug 2011 13:53:46 +0300
Message-ID: <1313578426.25065.1.camel@smile>
References: <1313577276-18182-1-git-send-email-deepthy.ravi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1313577276-18182-1-git-send-email-deepthy.ravi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Deepthy Ravi <deepthy.ravi@ti.com>
Cc: mchehab@infradead.org, linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Vaibhav Hiremath <hvaibhav@ti.com>
List-Id: linux-omap@vger.kernel.org

On Wed, 2011-08-17 at 16:04 +0530, Deepthy Ravi wrote: 
> From: Vaibhav Hiremath <hvaibhav@ti.com>
> 
> Defines the two functions only when CONFIG_MEDIA_CONTROLLER
> is enabled.
Is it not a driver's option to be dependent on MEDIA_CONTROLLER?


-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
