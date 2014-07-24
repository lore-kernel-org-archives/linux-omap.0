From: Oliver Neukum <oneukum@suse.de>
Subject: Re: [PATCH 00/10 linux-next] drivers/usb: remove unnecessary break
 after goto/return
Date: Thu, 24 Jul 2014 13:37:20 +0200
Message-ID: <1406201840.729.4.camel@linux-fkkt.site>
References: <1406189939-6433-1-git-send-email-fabf@skynet.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1406189939-6433-1-git-send-email-fabf@skynet.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabian Frederick <fabf@skynet.be>
Cc: linux-kernel@vger.kernel.org, joe@perches.com, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, usb-storage@lists.one-eyed-alien.net
List-Id: linux-omap@vger.kernel.org

On Thu, 2014-07-24 at 10:18 +0200, Fabian Frederick wrote:
> Small patchset addressing break redundancy on drivers/usb branch
> (suggested by Joe Perches).

Frankly, that is not a good idea. Somebody will remove a "goto"
and forget to readd the "break"

	Regards
		Oliver
