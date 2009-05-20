From: Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: N810: latest linux-omap-2.6.git master
Date: Thu, 21 May 2009 02:07:42 +0400
Message-ID: <200905210207.43061.jcmvbkbc@gmail.com>
References: <200905091745.06435.luke@dashjr.org> <20090513121219.43206b03.jhnikula@gmail.com> <200905190009.28222.luke@dashjr.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f176.google.com ([209.85.219.176]:57767 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754352AbZETWHv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 May 2009 18:07:51 -0400
Received: by ewy24 with SMTP id 24so857506ewy.37
        for <linux-omap@vger.kernel.org>; Wed, 20 May 2009 15:07:52 -0700 (PDT)
In-Reply-To: <200905190009.28222.luke@dashjr.org>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Luke-Jr <luke@dashjr.org>
Cc: Jarkko Nikula <jhnikula@gmail.com>, linux-omap@vger.kernel.org

> Yes, that change seemed to get me booting... however, with "rc6", the
> keyboard no longer works *at all*, and in neither rc4 nor rc6 does p54spi
> actually work.

For p54spi to minimally work you need at least the following patches from 
linux-wireless:

320abdf21a27e9f662f70d7726f56cd458343d3b
b4668d4eb59e0bc89059ba258c4aa278dcc3f872

For it to work good, all patches to drivers/net/wireless/p54 from linux-
wireless are required.

Thanks.
-- Max

