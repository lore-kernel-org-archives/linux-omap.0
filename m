From: Fabian Frederick <fabf@skynet.be>
Subject: Re: [PATCH 00/10 linux-next] drivers/usb: remove unnecessary break
 after goto/return
Date: Thu, 24 Jul 2014 17:46:42 +0200 (CEST)
Message-ID: <2081121229.1044862.1406216802363.open-xchange@webmail.nmp.skynet.be>
References: <1406189939-6433-1-git-send-email-fabf@skynet.be> <1406201840.729.4.camel@linux-fkkt.site>
Reply-To: Fabian Frederick <fabf@skynet.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1406201840.729.4.camel@linux-fkkt.site>
Sender: linux-kernel-owner@vger.kernel.org
To: Oliver Neukum <oneukum@suse.de>
Cc: usb-storage@lists.one-eyed-alien.net, joe@perches.com, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



> On 24 July 2014 at 13:37 Oliver Neukum <oneukum@suse.de> wrote:
>
>
> On Thu, 2014-07-24 at 10:18 +0200, Fabian Frederick wrote:
> > Small patchset addressing break redundancy on drivers/usb branch
> > (suggested by Joe Perches).
>
> Frankly, that is not a good idea. Somebody will remove a "goto"
> and forget to readd the "break"

No problem ; checkpatch would give a warning anyway. See "Possible swit=
ch
case/default not preceeded by break or fallthrough comment"

Regards,
=46abian
>
>=C2=A0 =C2=A0 =C2=A0 =C2=A0Regards
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Oliver
>
>
