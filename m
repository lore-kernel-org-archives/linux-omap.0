From: Mike Rapoport <mike.rapoport@gmail.com>
Subject: Re: [PATCH 0/2] OMAP: convert boards that use SMSC911x to use gpmc-smsc911x
Date: Tue, 19 Apr 2011 14:35:58 +0300
Message-ID: <BANLkTimHO1TUZsKHZ4akbGG9+C+AmVrP=A@mail.gmail.com>
References: <cover.1302992702.git.mike@compulab.co.il>
	<20110418112153.GK12272@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:58613 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751543Ab1DSLf7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Apr 2011 07:35:59 -0400
Received: by vws1 with SMTP id 1so4164980vws.19
        for <linux-omap@vger.kernel.org>; Tue, 19 Apr 2011 04:35:58 -0700 (PDT)
In-Reply-To: <20110418112153.GK12272@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Mike Rapoport <mike@compulab.co.il>, linux-omap@vger.kernel.org

Hi Tony,

On Mon, Apr 18, 2011 at 2:21 PM, Tony Lindgren <tony@atomide.com> wrote=
:
> * Mike Rapoport <mike@compulab.co.il> [110417 01:21]:
> Nice job Mike :)

There's a _lot_ of very similar code in different board files. If
you'd like to I can try to create something like
common-board-devices.c and move most of that code there. It's not the
real consolidation Linus wanted, but at least all the copy-pasted
device initialization code would be removed.


> Tony
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>



--=20
=A0 =A0 Sincerely Yours,
=A0 =A0 =A0 =A0 Mike.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
