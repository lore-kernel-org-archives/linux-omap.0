From: "Joe Woodward" <jw@terrafix.co.uk>
Subject: Re: Suspend broken on 3.3?
Date: Thu, 29 Mar 2012 10:46:43 +0100
Message-ID: <WC20120329094643.651766@terrafix.co.uk>
References: <87haxaq3ua.fsf@ti.com> <CAMrsUd++maNjaK87bcRUqVHtz5zySujQXZK1YaMH9vnHVWCDag@mail.gmail.com> <878viln2t5.fsf@ti.com> <CAMrsUdKXZL4nT0MW=BcD53PsQFE+W1inij3XWe0e5+BjJF3odg@mail.gmail.com> <WC20120328153855.621724@terrafix.co.uk> <87vcloipow.fsf@ti.com> <WC20120329083556.20174D@terrafix.co.uk> <CAM=Q2cvpUuy4kVynOrT+Rng1OgSqRmsS9e3uTTc=_fOwUgrD_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp1.keele.netcentral.co.uk ([212.57.235.197]:45296 "EHLO
	smtp3.keele.netcentral.co.uk" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1751796Ab2C2JrH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 29 Mar 2012 05:47:07 -0400
In-Reply-To: <CAM=Q2cvpUuy4kVynOrT+Rng1OgSqRmsS9e3uTTc=_fOwUgrD_g@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shubhrajyoti Datta <omaplinuxkernel@gmail.com>
Cc: Kevin Hilman <khilman@ti.com>, "Raja, Govindraj" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Paul Walmsley <paul@pwsan.com>, neilb@suse.de

> Hi Joe,
> 
> > After digging a bit further I found that the problem isn't lost
> characters or character corruption at all...
> >
> > The UART is actually at 460KBaud (not 900KBaud as I mentioned
> earlier).
> How did you verify that register read?
> 

I actually looked at the setting applied in my code (which I should have done earlier, oops :p).

...
  newtio.c_iflag = (IGNPAR);
  newtio.c_oflag = 0;
  newtio.c_cflag = B460800 | CS8 | CLOCAL | CREAD;
  newtio.c_lflag = 0;

  newtio.c_cc[VINTR]    = 0;     /* Ctrl-c */ 
  newtio.c_cc[VQUIT]    = 0;     /* Ctrl-\ */
  newtio.c_cc[VERASE]   = 0;     /* del */
  newtio.c_cc[VKILL]    = 0;     /* @ */
  newtio.c_cc[VEOF]     = 0;     /* Ctrl-d */
  newtio.c_cc[VTIME]    = 0;     /* inter-character timer unused */
  newtio.c_cc[VMIN]     = 1;     /* blocking read until 1 character arrives */
  newtio.c_cc[VSWTC]    = 0;     /* '\0' */
  newtio.c_cc[VSTART]   = 0;     /* Ctrl-q */ 
  newtio.c_cc[VSTOP]    = 0;     /* Ctrl-s */
  newtio.c_cc[VSUSP]    = 0;     /* Ctrl-z */
  newtio.c_cc[VEOL]     = 0;     /* '\0' */
  newtio.c_cc[VREPRINT] = 0;     /* Ctrl-r */
  newtio.c_cc[VDISCARD] = 0;     /* Ctrl-u */
  newtio.c_cc[VWERASE]  = 0;     /* Ctrl-w */
  newtio.c_cc[VLNEXT]   = 0;     /* Ctrl-v */
  newtio.c_cc[VEOL2]    = 0;     /* '\0' */

  /* Clean the modem line and activate the settings for the port
  */
  tcflush (handle->serialFD, TCIFLUSH);
  tcsetattr (handle->serialFD, TCSANOW, &newtio);
...

I then loop read from a file descriptor to see the received bytes:

  serialFD = open ("/dev/ttyO0", O_RDWR | O_NOCTTY); 
...
  while (1) {
    count = read (serialFD, buffer, MAXIMUM_LINE_LENGTH);
    ...
    debug here...
    ...
  }

And it's by inspecting the bytes read that I noticed the inserted 0x00 on 3.3.

> 
> The data received is very bursty (i.e. sets of messages every second
> or so), containing a
> > sync sequence to indicate a start of packet.
> >
> > The received bytes should be: 0x01, 0x52, 0x41 ....rest of packet.
> >
> > This works 100% of the time on 3.2, but on 3.3 I sometimes (but not
> always) get: 0x01, 0x00, 0x52, 0x41.
> >
> > i.e. there is a NULL/0x00 inserted after the first character.
> >
> > All this is tested using a very simple userspace application thats
> reads data from ttyO1.
> >
> > Any ideas? Should I kick open a new thread as it's not really to do
> with suspend anymore?
> Is there any flow control you are using?

No flow control, but lack of flow control hasn't caused problems up to 3.2.

Cheers,
Joe

> 
> >
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


