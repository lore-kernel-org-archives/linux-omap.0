From: Amit Virdi <amit.virdi@st.com>
Subject: Re: [PATCH 2/4] usb: dwc3: gadget: Stop TRB preparation after limit
 is reached
Date: Wed, 14 Jan 2015 14:39:55 +0530
Message-ID: <54B63263.4090201@st.com>
References: <20141222160626.GD12815@saruman> <CAEOkp44o-a1Onxwxp6rRZvN+vgWhALiNf=Z5FbRtyrOW2JWx=Q@mail.gmail.com> <20141227174628.GB17608@saruman> <CAEOkp447UBzCRfmCO1yy1_k4N40L_TsfbrCpoLXd=Wmav8JROg@mail.gmail.com> <20141229171232.GI29379@saruman> <CAEOkp466i87H2cRkG+GopsiqamV6Ym=Rm5Lbiqc2pk29X0Rt=w@mail.gmail.com> <20141230160215.GB415@saruman> <54AB7D3F.3030809@st.com> <20150112183459.GK6525@saruman> <54B4A394.5060005@st.com> <20150113162808.GF16533@saruman>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:43950 "EHLO
	mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752142AbbANJKZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Jan 2015 04:10:25 -0500
In-Reply-To: <20150113162808.GF16533@saruman>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "balbi@ti.com" <balbi@ti.com>
Cc: Amit Virdi <amitvi128@gmail.com>, Linux USB Mailing List <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Pratyush Anand Thakur <pratyush.anand@gmail.com>, Ajay KHANDELWAL <ajay.khandelwal@st.com>

> Alright, I just applied your patches to testing/fixes. I'll start
> testing today and should be able to send a pull request to Greg by the
> end of the week, hopefully.
>

Thanks! Just a small clarification - git failed to send patches to 
stable kernel list again (unfortunately I used the older configuration; 
so older git version - my bad).

Does these patches land up in the stable trees through maintainers or I 
should explicitly cc stable@vger.kernel.org now?
