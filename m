From: Fabian Frederick <fabf@skynet.be>
Subject: Re: [PATCH 02/35 linux-next] regulator: constify of_device_id array
Date: Tue, 17 Mar 2015 18:10:12 +0100 (CET)
Message-ID: <1489228275.7513.1426612212420.open-xchange@webmail.nmp.proximus.be>
References: <1426533469-25458-1-git-send-email-fabf@skynet.be> <1426533469-25458-3-git-send-email-fabf@skynet.be> <20150317121128.GH28806@sirena.org.uk>
Reply-To: Fabian Frederick <fabf@skynet.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mailsec118.isp.belgacom.be ([195.238.20.114]:63056 "EHLO
	mailsec118.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932521AbbCQRKO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 17 Mar 2015 13:10:14 -0400
In-Reply-To: <20150317121128.GH28806@sirena.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, linux-omap@vger.kernel.org, Joe Perches <joe@perches.com>



> On 17 March 2015 at 13:11 Mark Brown <broonie@kernel.org> wrote:
>
>
> On Mon, Mar 16, 2015 at 08:17:08PM +0100, Fabian Frederick wrote:
> > of_device_id is always used as const.
> > (See driver.of_match_table and open firmware functions)
>
> Applied, thanks.=C2=A0 Please remember to always include people in th=
e cover
> letter for patch serieses so they know what's going on with regard to
> dependencies and so on.

Thanks Mark, I used a --cc-cmd script by Joe Perches with
git send-email which uses --nom for cover-letter.

This limits recipients to mailing lists: 37 instead of 123 in this case=
=2E
I guess it's better to reduce the noise :)

Regards,
=46abian
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
