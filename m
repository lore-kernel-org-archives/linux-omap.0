From: Fabian Frederick <fabf@skynet.be>
Subject: Re: [PATCH 02/35 linux-next] regulator: constify of_device_id array
Date: Tue, 17 Mar 2015 18:26:17 +0100 (CET)
Message-ID: <239561179.7761.1426613177885.open-xchange@webmail.nmp.proximus.be>
References: <1426533469-25458-1-git-send-email-fabf@skynet.be> <1426533469-25458-3-git-send-email-fabf@skynet.be> <20150317121128.GH28806@sirena.org.uk> <1489228275.7513.1426612212420.open-xchange@webmail.nmp.proximus.be> <20150317171906.GQ28806@sirena.org.uk>
Reply-To: Fabian Frederick <fabf@skynet.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150317171906.GQ28806@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Joe Perches <joe@perches.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



> On 17 March 2015 at 18:19 Mark Brown <broonie@kernel.org> wrote:
>
>
> On Tue, Mar 17, 2015 at 06:10:12PM +0100, Fabian Frederick wrote:
>
> > Thanks Mark, I used a --cc-cmd script by Joe Perches with
> > git send-email which uses --nom for cover-letter.
>
> > This limits recipients to mailing lists: 37 instead of 123 in this =
case.
> > I guess it's better to reduce the noise :)
>
> Well, another thing to do if there's no dependencies is to just send
> each patch separately - there's no real relationship between the
> patches.=C2=A0 This also avoids the issue.

Such trivial updates are generally applied by David or Greg
after receiving some ack. That's the reason for the patchset :)
