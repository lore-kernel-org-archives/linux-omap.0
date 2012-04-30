From: Enrico <ebutera@users.sourceforge.net>
Subject: Re: "smsc911x: Add fixed board regulators" problem
Date: Mon, 30 Apr 2012 18:39:33 +0200
Message-ID: <CA+2YH7sDaL-qaLadHPTfgBJXKTO_N_Ug-yrBqzKbe0AXH6rT4g@mail.gmail.com>
References: <CA+2YH7tPBeJARm=ipq=HTtqNH6pDu8yQKMRMgL1Cz9rkSpzRBQ@mail.gmail.com>
	<20120430161155.GD3739@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:43568 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752073Ab2D3Qje convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Apr 2012 12:39:34 -0400
Received: by vcqp1 with SMTP id p1so2161756vcq.19
        for <linux-omap@vger.kernel.org>; Mon, 30 Apr 2012 09:39:33 -0700 (PDT)
In-Reply-To: <20120430161155.GD3739@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Russ Dill <Russ.Dill@ti.com>, Enric Balletbo i Serra <eballetbo@iseebcn.com>

On Mon, Apr 30, 2012 at 6:11 PM, Tony Lindgren <tony@atomide.com> wrote=
:
> Hi,
>
> * Enrico <ebutera@users.sourceforge.net> [120430 08:02]:
>> Hi,
>>
>> hi get this at boot on an IGEP board (igep0020), latest linux-omap
>> master (20 Apr):
>>
>> [ =A0 =A00.047704] WARNING: at fs/sysfs/dir.c:508 sysfs_add_one+0x9c=
/0xac()
>> [ =A0 =A00.047712] sysfs: cannot create duplicate filename
>> '/devices/platform/reg-fixed-voltage.0'
>
> This is because of trying to create multiple fixed regulators with
> id 0 as discussed earlier. AFAIK there's still no clean way to deal
> with that unfortunately..
>
> Can you try changing the id to something random like below?

Sorry i must have missed the discussion, i used 40 and it works. I'll
send a patch.

Thanks,

Enrico
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
