From: jouni.hogander@nokia.com (=?utf-8?Q?H=C3=B6gander?= Jouni)
Subject: Re: [PATCH] OMAP PM interface, version 2
Date: Wed, 18 Jun 2008 14:12:23 +0300
Message-ID: <87od5zatew.fsf@trdhcp146196.ntc.nokia.com>
References: <20080617145905.20886.89236.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:35817 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752692AbYFRLUE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Jun 2008 07:20:04 -0400
In-Reply-To: <20080617145905.20886.89236.stgit@localhost.localdomain> (ext
	Paul Walmsley's message of "Tue, 17 Jun 2008 09:01:22 -0600")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, khilman@mvista.com

"ext Paul Walmsley" <paul@pwsan.com> writes:

> Hello everyone,
>
> this is the second version of the OMAP PM interface patch.
>
> Major changes since the first version:
>
> 1. Jouni Hogander suggested that the set_max_cpu_lat() function be
>    merged into set_max_dev_wakeup_lat(), when set_max_dev_wakeup_lat(=
)
>    is called with the CPU0 sys_device (via get_cpu_sysdev(0)).  He fe=
els
>    that this will be easier for device driver developers to use.  Thi=
s
>    change has been made.

I just noticed that this won't work. We have this declaration:

(*pdata->set_max_dev_wakeup_lat)(struct device *dev, unsigned long t)

In case of cpu it is not possible to underlying code to identify the
caller. This derives a question should we have parameter for caller
identification in set_max_dev_wakeup_lat()?

I mean currently we are assuming that there is only one caller for
each device. Is this correct assumination? If we think
e.g. busses. There might be drivers for devices on some specific
bus. Each of them might want to set latency constraint for the bus.


--=20
Jouni H=C3=B6gander

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
