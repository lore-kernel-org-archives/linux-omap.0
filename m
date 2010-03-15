From: Ben Gamari <bgamari.foss@gmail.com>
Subject: Re: SPI troubles
Date: Mon, 15 Mar 2010 09:01:26 -0700 (PDT)
Message-ID: <4b9e59d6.0b38560a.5424.7bda@mx.google.com>
References: <4b9d9f11.9a15f10a.3902.6dc3@mx.google.com>
	<4B9E2725.6040803@balister.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f219.google.com ([209.85.220.219]:48865 "EHLO
	mail-fx0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965216Ab0COQB2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Mar 2010 12:01:28 -0400
Received: by fxm19 with SMTP id 19so3337952fxm.21
        for <linux-omap@vger.kernel.org>; Mon, 15 Mar 2010 09:01:26 -0700 (PDT)
In-Reply-To: <4B9E2725.6040803@balister.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Philip Balister <philip@balister.org>
Cc: beagleboard@googlegroups.com, spi-devel-general@lists.sourceforge.net, linux-omap@vger.kernel.org

On Mon, 15 Mar 2010 08:25:09 -0400, Philip Balister <philip@balister.org> wrote:
> For some reason you need to set the clock pin as an input. Here is the 
> config for mcspi1 that is working for me:
> 
> MUX_VAL(CP(MCSPI1_CLK),         (IEN  | PTD | DIS | M0)) /*McSPI1_CLK*/\
> 
> (from u-boot)
> 

Are you sure? Is this to fix the clock or does this really affect the MISO
signal? I have no problems with my clock at the moment. Everything appears to
work except for MISO. 

Cheers,

- Ben
