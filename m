From: <Kai.Vehmanen@nokia.com>
Subject: RE: [RFC PATCH 0/5] HSI framework and drivers
Date: Fri, 23 Apr 2010 21:44:16 +0200
Message-ID: <725063E4C37388418CDDC5A2C287906A16B778D24E@NOK-EUMSG-03.mgdnok.nokia.com>
References: <1272035728-6933-1-git-send-email-carlos.chinea@nokia.com>
 <alpine.DEB.2.00.1004231001190.29720@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.00.1004231001190.29720@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: paul@pwsan.com, Carlos.Chinea@nokia.com
Cc: linux-kernel@vger.kernel.org, s-jan@ti.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Paul and others,

On 23 April 2010, Paul Walmsley wrote:
>> SSI, which is a legacy version of HSI, is used to connect the applic=
ation
>> engine with the cellular modem on the Nokia N900.
>>
>> This patch set is based on 2.6.34-rc3
>
>Have you looked at S=E9bastien's HSI driver code:
>
>http://www.mail-archive.com/linux-omap@vger.kernel.org/msg18506.html

I think the history of the patches is already shared. I've been=20
looking at this from the sidelines and I think the story so=20
far is:

2008: Carlos sent the original SSI patchset (and got comments)
   -> http://lkml.org/lkml/2008/10/3/116
2009: S=E9bastien sent an updated patchset (and got comments)
   -> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg18506.h=
tml

=2E. and now this latest one from Carlos is a completely new
design that attempts to address the design comments that have
been raised, hopefully pushing HSI/SSI a step closer to=20
getting accepted. I'll leave it to Carlos and S=E9bastien to=20
correct me if I got the above wrong...

Br,
--=20
Kai Vehmanen
