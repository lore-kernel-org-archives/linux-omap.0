From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [RFC 00/24] OMAP serial driver flow control fixes, and
 preparation for DMA engine conversion
Date: Fri, 12 Oct 2012 17:51:51 +0300
Message-ID: <CANOLnOOewDVnsTmh9YyYCyG-5BrwDsTbSqDahazPsnM-6wBQYw@mail.gmail.com>
References: <20121006123803.GD15246@n2100.arm.linux.org.uk>
	<507427DA.6020409@ti.com>
	<87mwzuxjtc.fsf@deeprootsystems.com>
	<507694CF.3020204@ti.com>
	<20121011095443.GH28061@n2100.arm.linux.org.uk>
	<50769D8C.8030401@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <50769D8C.8030401@ti.com>
Sender: linux-serial-owner@vger.kernel.org
To: Sourav <sourav.poddar@ti.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Alan Cox <alan@linux.intel.com>
List-Id: linux-omap@vger.kernel.org

On Thu, Oct 11, 2012 at 1:21 PM, Sourav <sourav.poddar@ti.com> wrote:
> If you have any pointers on how to test hardware flow control, I will=
 like
> to do that on my beagle board.

If you can find some board with BT chip connected to UART, that would
be a good test as they usually have flow control lines connected and
can run at high bitrates. I think some EVM or Zoom boards have BT
chips.


--=20
Gra=C5=BEvydas
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
