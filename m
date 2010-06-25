From: Neshama Parhoti <pneshama@gmail.com>
Subject: Re: ZOOM2 doesn't boot on upstream kernel
Date: Fri, 25 Jun 2010 17:17:06 +0300
Message-ID: <AANLkTilLQbawpgWRq2aawszYKIdvsC-keyPFoAVTWWnr@mail.gmail.com>
References: <AANLkTilypMkwLYcpFCI5ZwSKOGHIAwDI7Bp9IdN9UAv_@mail.gmail.com>
	<2A3DCF3DA181AD40BDE86A3150B27B6B030DED31F3@dbde02.ent.ti.com>
	<AANLkTikkCeusIKA2KyRcVWbxVXKmLA8-_RfC2A4u3ySM@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.153]:23886 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756198Ab0FYORI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Jun 2010 10:17:08 -0400
Received: by fg-out-1718.google.com with SMTP id l26so1255929fgb.1
        for <linux-omap@vger.kernel.org>; Fri, 25 Jun 2010 07:17:06 -0700 (PDT)
In-Reply-To: <AANLkTikkCeusIKA2KyRcVWbxVXKmLA8-_RfC2A4u3ySM@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ghorai, Sukumar" <s-ghorai@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, Jun 25, 2010 at 5:05 PM, Neshama Parhoti <pneshama@gmail.com> wrote:
>> 1. console=ttyS0


you are absolutely right !!!!!!!

i changed it to ttyS0 and now I get the boot msgs ! :)


can you please check out my whole boot args to see if i have any other error ?

just to make sure..

setenv bootcmd 'tftpboot 0x81C00000 /srv/tftp/uImage; bootm 0x81C00000'
setenv nfsdata nfsroot=192.168.1.4:/home/pnesh/myfs,nolock,devfs=mount
ip=192.168.1.160
setenv bootargs console=ttyS3,115200n8 root=/dev/nfs rw rootdelay=1
mem=256M init=/init videoout=omap24xxvout
omap_vout.video1_numbuffers=4 omap_vout.vid1_static_vrfb_alloc=y
${nfsdata}


thank you a lot !!
