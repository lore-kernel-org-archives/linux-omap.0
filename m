From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: tty driver crash in LInux Kernel 3.8
Date: Wed, 17 Aug 2016 11:50:16 +0200
Message-ID: <20160817095016.GB17906@kroah.com>
References: <CAMNxYswaQ8h8oPHzJWa1VX_QcbSY6++=O92rq-zFSx-7twg13w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMNxYswaQ8h8oPHzJWa1VX_QcbSY6++=O92rq-zFSx-7twg13w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Priyaranjan Das <priyaranjan456789@gmail.com>
Cc: linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Priyaranjan Das <priyaranjan45678@gmail.com>
List-Id: linux-omap@vger.kernel.org

On Wed, Aug 17, 2016 at 02:29:39PM +0530, Priyaranjan Das wrote:
> Hello All,
> 
> I need help in finding a fix of an issue of TTY LDISC for Kernel 3.8.

Ouch that's an old and obsolete and insecure kernel version that is
hundreds of thousands of fixes and changes old :(

Please ask for support from the vendor that is forcing you to use such a
beast, you are paying for it, might as well take advantage of it.
Nothing the kernel community can do, sorry.

Note, if you can reproduce this on 4.8-rc2 or even 4.7.1, we will be
glad to help out here.

Best of luck,

greg k-h
