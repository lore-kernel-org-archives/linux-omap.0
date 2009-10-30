From: James Mastros <james@mastros.biz>
Subject: Re: [PATCH 1/3] Input: add new keycodes useful in mobile devices
Date: Fri, 30 Oct 2009 21:41:07 +0000
Message-ID: <abc933c50910301441l32e3dc0es3ffdbaacee8824e2@mail.gmail.com>
References: <20091027162040.GB22541@core.coreip.homeip.net>
	 <cover.1256907278.git.ext-jani.1.nikula@nokia.com>
	 <48e6c73d2c8e67e1d2eec68556e7885f6d10c203.1256907278.git.ext-jani.1.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <48e6c73d2c8e67e1d2eec68556e7885f6d10c203.1256907278.git.ext-jani.1.nikula@nokia.com>
Sender: linux-input-owner@vger.kernel.org
To: Jani Nikula <ext-jani.1.nikula@nokia.com>
Cc: tony@atomide.com, dmitry.torokhov@gmail.com, linux-omap@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

> +#define SW_CAMERA_LENSE_COVER =C2=A00x09 =C2=A0/* set =3D lense cove=
red */

The correct spelling is "lens", no trailing "e".  (If it were a
comment, I wouldn't care, but in a constant it's far more important.

   -=3D- James Mastros
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
