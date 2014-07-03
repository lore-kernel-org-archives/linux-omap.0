From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: am335x: system doesn't reboot after flashing NAND
Date: Thu, 3 Jul 2014 15:52:12 +0530
Message-ID: <53B52ED4.8030607@ti.com>
References: <CAGm1_kstgCEQRuaz836v7xg=DHVxpQ6VQPBzkORz1D=18fxp8w@mail.gmail.com> <CAGm1_kv7EmQ1MaXL0nhQcPZp53DjBLfdnTqFit9e0FT1J8zzug@mail.gmail.com> <538EBF54.7080709@ti.com> <CAGm1_ktWxQFQ0jWjn7A2NO8nPayY9S2McPrKHWbGRtkw1751ig@mail.gmail.com> <538EDD77.8070807@ti.com> <CAGm1_kt7BZ7RcbPd51QXhXxQV4SRzeXLzKW43wqK5UnPbYoHBw@mail.gmail.com> <538EF2EF.4050709@ti.com> <CAGm1_ksofkCNB1R9kg6L9FBFFPoE=62AZ1Vid4_n7DEu1oi4GQ@mail.gmail.com> <538EFA70.4040102@ti.com> <CAGm1_ktjgSnQmBPDVUf_6kWjZDJ3WKQv=5QMWmqWqP-XRp7k2Q@mail.gmail.com> <53904038.8010200@ti.com> <CAGm1_ktfN+whCNAStC=sx_6PrH9EJNVe67xK1xdTkGMNjcTwJg@mail.gmail.com> <53918B04.6050007@ti.com> <CAGm1_kuz8ch4K_okred8+3qogWdX1qO6mYGmBiMe8SHt89zKPQ@mail.gmail.com> <CAGm1_ktGPi8GB7U3CMB9C0NfkG1PRyKJt1vi3VJ8q5EYY8G7qg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49559 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758548AbaGCKWQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 Jul 2014 06:22:16 -0400
In-Reply-To: <CAGm1_ktGPi8GB7U3CMB9C0NfkG1PRyKJt1vi3VJ8q5EYY8G7qg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Yegor Yefremov <yegorslists@googlemail.com>, Roger Quadros <rogerq@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Gupta, Pekon" <pekon@ti.com>, "Vutla, Lokesh" <lokeshvutla@ti.com>

On Thursday 03 July 2014 02:45 AM, Yegor Yefremov wrote:
> Btw how can I debug the kernel via JTAG? I've read, that one must
> activate JTAG clock or something like this. What is the proper way to
> do this in 3.15 - 3.16?

Please try with Lokesh's patch here:

http://www.spinics.net/lists/arm-kernel/msg320801.html

Thanks,
Sekhar

