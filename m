From: Amit Virdi <amit.virdi@st.com>
Subject: Re: [PATCH RESEND 0/2] usb: dwc3: gadget: Bug fixes
Date: Tue, 13 Jan 2015 14:16:15 +0530
Message-ID: <54B4DB57.4020009@st.com>
References: <cover.1421130636.git.amit.virdi@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:56720 "EHLO
	mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751649AbbAMIqo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Jan 2015 03:46:44 -0500
In-Reply-To: <cover.1421130636.git.amit.virdi@st.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "balbi@ti.com" <balbi@ti.com>, "pratyush.anand@gmail.com" <pratyush.anand@gmail.com>, Ajay KHANDELWAL <ajay.khandelwal@st.com>

On 1/13/2015 12:10 PM, Amit VIRDI wrote:
> This is a re-submission of patches [1/4] and [2/4] from:
> 	http://www.spinics.net/lists/linux-usb/msg118841.html
>
> Commit log of both these patches has been modified for aided clarity. These
> patches have been rebased on Balbi's testing/next.
>
> Patches [3/4] and [4/4] were accepted as they were.
>
> Amit Virdi (2):
>    usb: dwc3: gadget: Fix TRB preparation during SG
>    usb: dwc3: gadget: Stop TRB preparation after limit is reached
>
>   drivers/usb/dwc3/gadget.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
>

I was using older git version, so git failed to send patches to 
stable@vger.kernel.org

Please discard this patchset. I'm resending with updated git
