From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 00/10 linux-next] drivers/usb: remove unnecessary break
 after goto/return
Date: Thu, 24 Jul 2014 08:52:11 -0700
Message-ID: <1406217131.27221.27.camel@joe-AO725>
References: <1406189939-6433-1-git-send-email-fabf@skynet.be>
	 <1406201840.729.4.camel@linux-fkkt.site>
	 <2081121229.1044862.1406216802363.open-xchange@webmail.nmp.skynet.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2081121229.1044862.1406216802363.open-xchange@webmail.nmp.skynet.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabian Frederick <fabf@skynet.be>
Cc: Oliver Neukum <oneukum@suse.de>, usb-storage@lists.one-eyed-alien.net, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thu, 2014-07-24 at 17:46 +0200, Fabian Frederick wrote:
> 
> > On 24 July 2014 at 13:37 Oliver Neukum <oneukum@suse.de> wrote:
> >
> >
> > On Thu, 2014-07-24 at 10:18 +0200, Fabian Frederick wrote:
> > > Small patchset addressing break redundancy on drivers/usb branch
> > > (suggested by Joe Perches).
> >
> > Frankly, that is not a good idea. Somebody will remove a "goto"
> > and forget to readd the "break"
> 
> No problem ; checkpatch would give a warning anyway. See "Possible switch
> case/default not preceeded by break or fallthrough comment"

Generally true, but not everyone uses checkpatch.
