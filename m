From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [RFC PATCH 0/5] HSI framework and drivers
Date: Fri, 23 Apr 2010 10:02:57 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1004231001190.29720@utopia.booyaka.com>
References: <1272035728-6933-1-git-send-email-carlos.chinea@nokia.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-7893282-1272038577=:29720"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1272035728-6933-1-git-send-email-carlos.chinea@nokia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Carlos Chinea <carlos.chinea@nokia.com>
Cc: linux-kernel@vger.kernel.org, s-jan@ti.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-7893282-1272038577=:29720
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

(cc S=E9bastien JAN)

Hello Carlos,

On Fri, 23 Apr 2010, Carlos Chinea wrote:

> I have been working on a new proposal to support HSI/SSI drivers
> in the kernel. I would be very glad to get your feedback about
> this proposal.
>=20
> This patch series introduces the HSI framework, an SSI driver
> for OMAP and a generic character device for HSI/SSI devices.
>=20
> SSI, which is a legacy version of HSI, is used to connect the application
> engine with the cellular modem on the Nokia N900.
>=20
> This patch set is based on 2.6.34-rc3

Have you looked at S=E9bastien's HSI driver code:

http://www.mail-archive.com/linux-omap@vger.kernel.org/msg18506.html

Is there some way that you can combine efforts with him?


- Paul
--155748971-7893282-1272038577=:29720--
