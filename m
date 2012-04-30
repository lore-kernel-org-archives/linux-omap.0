From: jean-philippe francois <jp.francois@cynove.com>
Subject: OMAP3 previewer bayer pattern selection
Date: Mon, 30 Apr 2012 12:23:27 +0200
Message-ID: <CAGGh5h01=YdRtmhe1pXpvmXSPP5e1UPBtqGbN3c2tTbjdmEtVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-media-owner@vger.kernel.org>
Sender: linux-media-owner@vger.kernel.org
To: linux-media <linux-media@vger.kernel.org>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

I am trying to get a working preview from a CMOS
sensor with a CFA bayer pattern.

Does the CCDC_COLPTN register have any effect on
previewer CFA interpolation ?

=46rom my experience it does not. I can set BGGR or GRBG,
but the output is always the same. When doing raw capture,
I get nice image if I use a BGGR pattern for my software bayer
to rgb interpolation. When using previewer, the output looks like
BGGR interpreted as GRBG, ie blue and red are green, and green
turns into purple.

Looking at the driver code (mainline), there is nothing about bayer ord=
er
in the previewer code. Looking at the TRM, theres is also nothing in
the previewer
part about bayer order.

How are we supposed to debayer something different from GRBG ?
By modifying the cfa_coef_table table ?
Cropping at the previewer output to start on an odd line ?

Thank you for any pointer on this issue.

Jean-Philippe Fran=E7ois
