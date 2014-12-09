From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: __hci_cmd_sync() not suitable for nokia h4p
Date: Tue, 9 Dec 2014 20:07:45 +0100
Message-ID: <304050AD-DB11-4A2B-A1F7-8B1BBB5F04F0@holtmann.org>
References: <20141209190210.GA15641@amd>
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20141209190210.GA15641@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: =?utf-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>, sre@debian.org, Sebastian Reichel <sre@ring0.de>, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, tony@atomide.com, khilman@kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>, =?utf-8?B?0JjQstCw0LnQu9C+INCU0LjQvNC40YLRgNC+0LI=?= <freemangordon@abv.bg>, "Gustavo F. Padovan" <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>, linux-bluetooth@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Pavel,

> Major problem with Nokia H4P driver was, that it uses custom functions
> instead of __hci_cmd_sync().

the __hci_cmd_sync is for sending HCI commands and not low-level protocol transports like H:4 or similar. So you want to separate the actual transport of HCI from the firmware loading.

Regards

Marcel
