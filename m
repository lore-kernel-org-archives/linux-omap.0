From: "R, Sricharan" <r.sricharan@ti.com>
Subject: Re: [PATCH 01/13] ARM: OMAP5: id: Add cpu id for ES versions
Date: Thu, 10 May 2012 18:45:52 +0530
Message-ID: <CAJ7qFSeEwxdmqBxZdmABwthnTH1EWZJLJp68To8zit0XLWQhHw@mail.gmail.com>
References: <1336029982-31898-1-git-send-email-r.sricharan@ti.com>
	<1336029982-31898-2-git-send-email-r.sricharan@ti.com>
	<20120510130637.GA24672@game.jcrosoft.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:40887 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753090Ab2EJNPz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 May 2012 09:15:55 -0400
Received: by lbjn8 with SMTP id n8so1319827lbj.0
        for <linux-omap@vger.kernel.org>; Thu, 10 May 2012 06:15:52 -0700 (PDT)
In-Reply-To: <20120510130637.GA24672@game.jcrosoft.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, santosh.shilimkar@ti.com, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org

Hi J,

> why do you duplicate this
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 case 1:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_revision =3D OMAP5430=
_REV_ES2_0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> do this
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case 0:
>> + =A0 =A0 =A0 =A0 =A0 =A0 default:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_revision =3D OMAP5430=
_REV_ES1_0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> +
>> + =A0 =A0 case 0xb998:
>> + =A0 =A0 =A0 =A0 =A0 =A0 switch (rev) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 case 0:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_revision =3D OMAP5432=
_REV_ES1_0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 default:
> ditto here

   Agree. Will correct the redundancy.

Thanks,
 Sricharan
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
