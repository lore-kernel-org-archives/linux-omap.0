From: Pantelis Antoniou <panto@antoniou-consulting.com>
Subject: Re: [PATCH] musb: Kill __init from function that are called at other times as well.
Date: Thu, 6 Sep 2012 20:42:56 +0300
Message-ID: <5607ED12-1C7D-4455-A716-F611B747BADF@antoniou-consulting.com>
References: <1346940106-20269-1-git-send-email-panto@antoniou-consulting.com> <20120906130425.GF29202@arwen.pp.htv.fi> <B7BE7E99-90E8-4E54-B146-C09C6643BAFE@antoniou-consulting.com> <20120906170740.GB17754@arwen.pp.htv.fi> <7CED20FA-3501-40ED-B289-28FDC04FCF20@antoniou-consulting.com> <20120906173724.GE30717@arwen.pp.htv.fi>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from li42-95.members.linode.com ([209.123.162.95]:56337 "EHLO
	li42-95.members.linode.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759396Ab2IFRnA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Sep 2012 13:43:00 -0400
In-Reply-To: <20120906173724.GE30717@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: linux-omap@vger.kernel.org, USB list <linux-usb@vger.kernel.org>, Russ Dill <Russ.Dill@ti.com>


On Sep 6, 2012, at 8:37 PM, Felipe Balbi wrote:

> Hi,
> 
> On Thu, Sep 06, 2012 at 08:36:39PM +0300, Pantelis Antoniou wrote:
>> Hi Felipe
>> 
>> I see about __devinit.
>> There's no crash because in those logs the __init modifiers are gone.
> 
> it'd be cool to see the crash, though ;-)
> 
> -- 
> balbi

Heh, OK,

My word is not enough? :)

Gimme a few minutes...

-- Pantelis

