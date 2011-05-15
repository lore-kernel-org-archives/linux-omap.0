From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: dsp
Date: Sun, 15 May 2011 23:57:32 +0200
Message-ID: <201105152357.32261.laurent.pinchart@ideasonboard.com>
References: <F752F64AD8BC1D42B49B877FEE3CD34901709F24@USTED.BOPTUS.OPTIK.LAN>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:52758 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750882Ab1EOV42 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 15 May 2011 17:56:28 -0400
In-Reply-To: <F752F64AD8BC1D42B49B877FEE3CD34901709F24@USTED.BOPTUS.OPTIK.LAN>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jeg@brukeroptics.com
Cc: linux-omap Mailing List <linux-omap@vger.kernel.org>

Hi Jeff,

On Saturday 14 May 2011 17:49:58 Jeff Graham wrote:
> Hello,
> 
> I see a lot of great kernel work on the omaps.
> 
> I have a dm3730 with a DSP.
> 
> I am wondering if there is any work to make using the DSPs that are part
> of some chips easier to use in some standard way such as /dev or MPI or
> some other abstraction.

There's currently no standard user/kernel API to handle communication with 
DSPs. For the OMAP3, http://code.google.com/p/gst-dsp/downloads/list can be 
interesting.

-- 
Regards,

Laurent Pinchart
