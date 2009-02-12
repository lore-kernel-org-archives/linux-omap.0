From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: omapfb: 24bpp not working?
Date: Thu, 12 Feb 2009 12:39:13 +0200
Message-ID: <6ed0b2680902120239s3e92d32fh5c179e1b0163220c@mail.gmail.com>
References: <cb7bedd90902120150l609ee132rfc76f28b223e923b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.189]:42648 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757876AbZBLKjP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Feb 2009 05:39:15 -0500
Received: by fk-out-0910.google.com with SMTP id f33so273005fkf.5
        for <linux-omap@vger.kernel.org>; Thu, 12 Feb 2009 02:39:14 -0800 (PST)
In-Reply-To: <cb7bedd90902120150l609ee132rfc76f28b223e923b@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Matthias Ludwig <matthias.ludwig@gmx.net>
Cc: linux-omap@vger.kernel.org

On Thu, Feb 12, 2009 at 11:50 AM, Matthias Ludwig
<matthias.ludwig@gmx.net> wrote:
> Hi all,
>
> I selected a 1024x768x24bpp in the drivers/video/omap/lcd_xxx file for
> a new platform (very similar to OMAP3EVM) which has a display
> connected to the CPU using a LVDS-transmitter. Everything works find,
> but the systems does not send 888-RGB-values but 565 ones, even if i
> select bpp = 24 and data_lines = 24 in my lcd-configuration.
>
> The framebuffer-device has the correct size (dd if=/dev/fb0
> of=/tmp/fb-dump gives me a file which is 1024x768x3=2359296 bytes).
> If i fill the display up with a solid color and then run following command:
> dd if=/dev/zero of=/dev/fb0 bs=1024 count=1
> half a display-line is getting black (should only be 1 third)

AFAIK current driver doesn't support 24bpp, search for
work-in-progress driver called DSS2. It's not merged in yet, so you'll
need to apply it manually.
