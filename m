From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Subject: Re: Git tree updated to v2.6.27-rc5, some USB diffs still lurking
Date: Thu, 04 Sep 2008 01:22:03 +0100
Message-ID: <yw1xprnklpzo.fsf@thrashbarg.mansr.com>
References: <20080903221218.GD23085@atomide.com> <20080903232754.GR19980@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:49625 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751416AbYIDAZJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 3 Sep 2008 20:25:09 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1Kb2el-0008VF-4S
	for linux-omap@vger.kernel.org; Thu, 04 Sep 2008 00:25:03 +0000
Received: from thrashbarg.mansr.com ([78.86.181.100])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Thu, 04 Sep 2008 00:25:03 +0000
Received: from mans by thrashbarg.mansr.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Thu, 04 Sep 2008 00:25:03 +0000
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

> On Wed, Sep 03, 2008 at 03:12:19PM -0700, Tony Lindgren wrote:
>
>> +#define	OMAP_USBHOST_TLL_BASE	(OMAP_USBHOST_BASE + 0x2000)
>> +#define	OMAP_USBTLL_REVISION	(OMAP_USBHOST_TLL_BASE + 0x00)
>> +#define	OMAP_USBTLL_SYSCONFIG	(OMAP_USBHOST_TLL_BASE + 0x10)
>> +	#define	OMAP_USBTLL_SYSCONFIG_CACTIVITY_SHIFT	8
>> +	#define	OMAP_USBTLL_SYSCONFIG_SIDLEMODE_SHIFT	3
>
> And, fyi, gcc may currently accept this, but I seem to remember that
> the C standard doesn't permit this - the '#' should always be in
> column 0, optionally followed by white space before the directive.

C99 allows whitespace before the # character.  Older versions may have
had this restriction; I don't have a copy available.

--=20
M=E5ns Rullg=E5rd
mans@mansr.com

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
