From: Krishna Kishore <krishna.kishore@sasken.com>
Subject: RE: OMAP3430 clock settings
Date: Wed, 14 Jan 2009 16:44:18 +0530
Message-ID: <F9F1042FDECC134ABFBF4EC5EBEC88DAB357EF@EXGZ02.sasken.com>
References: <1231897985-5274-1-git-send-email-stanley.miao@windriver.com> <F9F1042FDECC134ABFBF4EC5EBEC88DAB35794@EXGZ02.sasken.com> <3a2dabf50901140100i63899449ud8fee54bd7763bff@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mta-blr2.sasken.com ([164.164.56.19]:62467 "EHLO
	mta-blr2.sasken.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753709AbZANLOh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Jan 2009 06:14:37 -0500
Content-Class: urn:content-classes:message
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ramesh Gupta Guntha <grgupta77@gmail.com>
Cc: linux-omap@vger.kernel.org


Hi Ramesh Guptha,

   Thanks a lot for your response.

   We can check this PRCM section. 
   After reading IVA2_CM and MPU_CM registers, I want to know how to
calculate the clock speeds.
   Since this procedure/formula will already be known, can you please
let me know?

Regards,
Kishore.
 

-----Original Message-----
From: Ramesh Gupta Guntha [mailto:grgupta77@gmail.com] 
Sent: Wednesday, January 14, 2009 2:31 PM
To: Krishna Kishore
Cc: linux-omap@vger.kernel.org
Subject: Re: OMAP3430 clock settings

Hi Krishna,

On 1/14/09, Krishna Kishore <krishna.kishore@sasken.com> wrote:

>   We need to find this out during runtime. Which register to read and 
> how to
>   know the clock settings of DSP, ARM and L3?

Please refer to PRCM and Interconnect sections of the TRM, you may be
interested in IVA2_CM, MPU_CM etc.

thanks
Ramesh
SASKEN BUSINESS DISCLAIMER
-------------------------
This message may contain confidential, proprietary or legally privileged information. In 
case you are not the original intended Recipient of the message, you must not, directly or 
indirectly, use, Disclose, distribute, print, or copy any part of this message and you are 
requested to delete it and inform the sender. Any views expressed in this message are 
those of the individual sender unless otherwise stated. Nothing contained in this message 
shall be construed as an offer or acceptance of any offer by Sasken Communication 
Technologies Limited ("Sasken") unless sent with that express intent and with due 
authority of Sasken. Sasken has taken enough precautions to prevent the spread of 
viruses. However the company accepts no liability for any damage caused by any virus 
transmitted by this email

