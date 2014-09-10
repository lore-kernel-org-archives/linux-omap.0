From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 00/16 v9] omap 8250 based uart + DMA
Date: Wed, 10 Sep 2014 21:29:55 +0200
Message-ID: <1410377411-26656-1-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Sender: linux-serial-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, balbi@ti.com, gregkh@linuxfoundation.org
List-Id: linux-omap@vger.kernel.org

the diff of v8=E2=80=A6v9 is small:
- rebased on top's of Greg's tty-next branch
- fixed #10 where we might have THRE interrupt enabled for longer than
  needed
- re-did register setup in #10. Before this "less file" could freeze th=
e
  am335x-evm.

Sebastian

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
