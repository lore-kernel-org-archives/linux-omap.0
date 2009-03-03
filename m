From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 1/1] Group and resource assignments for TWL4030
Date: Tue, 3 Mar 2009 15:28:45 -0800
Message-ID: <200903031528.45940.david-b@pacbell.net>
References: <1234271495-11705-1-git-send-email-peter.de-schrijver@nokia.com> <1234271495-11705-2-git-send-email-peter.de-schrijver@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp116.sbc.mail.sp1.yahoo.com ([69.147.64.89]:20603 "HELO
	smtp116.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751945AbZCCX2t (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Mar 2009 18:28:49 -0500
In-Reply-To: <1234271495-11705-2-git-send-email-peter.de-schrijver@nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
Cc: linux-omap@vger.kernel.org

On Tuesday 10 February 2009, Peter 'p2' De Schrijver wrote:
> +struct twl4030_resconfig {
> +=A0=A0=A0=A0=A0=A0=A0int resource;
> +=A0=A0=A0=A0=A0=A0=A0int devgroup;
> +=A0=A0=A0=A0=A0=A0=A0int type;
> +=A0=A0=A0=A0=A0=A0=A0int type2;
> +};
> +

Make all those "u8" ... save 28 * 3 * 4 =3D=3D 336 bytes
on a system that configures all 28 resources.  ;)


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
