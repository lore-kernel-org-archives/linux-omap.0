From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH 4/8] USB: musb: suppress warning about unused flags
Date: Mon, 28 Jun 2010 21:27:23 +0400
Message-ID: <4C28DB7B.5010100@ru.mvista.com>
References: <1276771242-5201-1-git-send-email-ajay.gupta@ti.com> <1276771242-5201-2-git-send-email-ajay.gupta@ti.com> <1276771242-5201-3-git-send-email-ajay.gupta@ti.com> <1276771242-5201-4-git-send-email-ajay.gupta@ti.com> <1276771242-5201-5-git-send-email-ajay.gupta@ti.com> <20100624060857.GG8078@nokia.com> <4C232A4C.6040102@ru.mvista.com> <20100628142445.GA21562@gandalf>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:60801 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753130Ab0F1R22 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Jun 2010 13:28:28 -0400
In-Reply-To: <20100628142445.GA21562@gandalf>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: me@felipebalbi.com
Cc: Sergei Shtylyov <sshtylyov@mvista.com>, felipe.balbi@nokia.com, ext Ajay Kumar Gupta <ajay.gupta@ti.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "gregkh@suse.de" <gregkh@suse.de>, Jon Povey <jon.povey@racelogic.co.uk>

Hello.

Felipe Balbi wrote:

>>> I think the problem here is different. First of all, an IRQ of number 0 
>>> is valid

>>     It's not valid for this driver.

> it's not valid for the boards we have available so far.

    And the current driver doesn't accept it as a valid IRQ.

WBR, Sergei
