From: Archit Taneja <a0393947@ti.com>
Subject: Re: [RFC 00/17] OMAPDSS: Change way of passing timings from panel
 driver to interface
Date: Wed, 8 Aug 2012 11:35:43 +0530
Message-ID: <502201B7.9030205@ti.com>
References: <1343817088-29645-1-git-send-email-archit@ti.com> <1344349948.7216.82.camel@lappyti>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51764 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751415Ab2HHGHJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 8 Aug 2012 02:07:09 -0400
In-Reply-To: <1344349948.7216.82.camel@lappyti>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, sumit.semwal@ti.com, rob@ti.com

On Tuesday 07 August 2012 08:02 PM, Tomi Valkeinen wrote:
> On Wed, 2012-08-01 at 16:01 +0530, Archit Taneja wrote:
>> This series tries to make interface drivers less dependent on omap_dss_device
>> which represents a panel/device connected to that interface. The current way of
>> configuring an interface is to populate the panel's omap_dss_device instance
>> with parameters common to the panel and the interface, they are either populated
>> in the board file, or in the panel driver. Panel timings, number of lanes
>> connected to interface, and pixel format are examples of such parameters, these
>> are then extracted by the interface driver to configure itself.
>
> The series looks good. I had only a few comments to make, but obviously
> this needs quite a bit of testing. I'll try it out.

One thing I'm not sure about is whether these new functions should be 
aware of the state of the output. For example, if we call set_timings() 
with DSI video mode which is already enabled, the timings won't really 
take any impact.

Similar issues would occur when we try to make other ops like 
set_data_lines() or set_pixel_format(). These need to be called before 
the output is enabled. I was wondering if we would need to add 
intelligence here to make panel drivers less likely to make mistakes.

Archit
