From: "Ramesh Gupta Guntha" <grgupta77@gmail.com>
Subject: Re: OMAP3430 clock settings
Date: Wed, 14 Jan 2009 14:30:51 +0530
Message-ID: <3a2dabf50901140100i63899449ud8fee54bd7763bff@mail.gmail.com>
References: <1231897985-5274-1-git-send-email-stanley.miao@windriver.com>
	 <F9F1042FDECC134ABFBF4EC5EBEC88DAB35794@EXGZ02.sasken.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.227]:12467 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755596AbZANJAv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Jan 2009 04:00:51 -0500
Received: by rv-out-0506.google.com with SMTP id k40so436073rvb.1
        for <linux-omap@vger.kernel.org>; Wed, 14 Jan 2009 01:00:51 -0800 (PST)
In-Reply-To: <F9F1042FDECC134ABFBF4EC5EBEC88DAB35794@EXGZ02.sasken.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Krishna Kishore <krishna.kishore@sasken.com>
Cc: linux-omap@vger.kernel.org

Hi Krishna,

On 1/14/09, Krishna Kishore <krishna.kishore@sasken.com> wrote:

>   We need to find this out during runtime. Which register to read and
> how to
>   know the clock settings of DSP, ARM and L3?

Please refer to PRCM and Interconnect sections of the TRM, you may be
interested in IVA2_CM, MPU_CM etc.

thanks
Ramesh
