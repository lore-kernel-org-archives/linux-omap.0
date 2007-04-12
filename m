From: "nishanth menon" <menon.nishanth@gmail.com>
Subject: Re: about OMAP usb Speed?
Date: Thu, 12 Apr 2007 18:51:43 -0500
Message-ID: <782515bb0704121651u70a661daof21e51e074568fca@mail.gmail.com>
References: <bd205c5f0704111728u57837375j22960eed269e4489@mail.gmail.com>
	<200704121530.04125.marek.vasut@gmail.com>
	<3B6D69C3A9EBCA4BA5DA60D913027429BDB8E9@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <3B6D69C3A9EBCA4BA5DA60D913027429BDB8E9@dlee13.ent.ti.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Richard,

On 4/12/07, Woodruff, Richard <r-woodruff2@ti.com> wrote:

> Also as I recall, OTG didn't come about until the USB2.0 time frame.  I don't think you will find an OTG which claims to be 1.1.  Usually it is 2.0 compliant and adheres to some supplement level.
Yup, OTG spec is addendum to 2.0 spec. But just for the sake for
curiosity, Back in 2002, we did have some controllers which were
USB1.1 compliant AND supported OTG+SRP. USB1.1 compliance was the
chapter9 commands of 1.1 spec, host, I dont recollect if it was OHCI
or some "non standard embedded host controller" though... in short, we
could have USB 1.1 compliance for A-peripheral and B-peripheral(using
OTG terminology), but support SRP&HNP becoming "USB1.1 OTG". Only i
guess, it would be "near-compliant"(if such a word could be used) to
specs. I would be surprised to see such devices still existing.. the
2.0 OTG compliance is almost common place today..

Regards,
Nishanth Menon
