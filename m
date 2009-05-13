From: "Eugeny S. Mints" <eugeny.mints@gmail.com>
Subject: Re: PM branch updates
Date: Wed, 13 May 2009 23:41:22 +0400
Message-ID: <4A0B2262.4020904@gmail.com>
References: <87pred6jff.fsf@deeprootsystems.com> <87bppx6j0q.fsf@deeprootsystems.com> <F59CF5AD-5251-4C08-9BEE-70B7E27A62C2@mac.com> <87tz3p53j8.fsf@deeprootsystems.com> <76CCCDC7-9E68-4965-AD8E-ABE8C11317FD@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from postoffice.embeddedalley.com ([65.114.89.228]:50563 "HELO
	postoffice.embeddedalley.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753292AbZEMTlR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 May 2009 15:41:17 -0400
In-Reply-To: <76CCCDC7-9E68-4965-AD8E-ABE8C11317FD@mac.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Elvis Dowson <elvis.dowson@mac.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org

Elvis,

Elvis Dowson wrote:
> Hi Kevin,
>             Thanks for the reply. I am working with the gumstix overo 
> TI OMAP 3503, and just finished porting android-2.6.29 to this 
> platform. Towards the end I noticed that there was no power management 
> available for the OMAP !! And I used the same git repository, pulled 
> nearly all the PM patches, except the SR ones, which didn't work.
FYI, there is Google's android-2.6.29 omap git tree available at 
http://android.git.kernel.org/?p=kernel/omap.git;a=shortlog;h=refs/heads/android-omap-2.6.29 

which has pretty much all (except recent changes) patches from PM branch 
integrated.

Eugeny


>
> Elvis Dowson
>
> On May 13, 2009, at 8:14 PM, Kevin Hilman wrote:
>
>> Elvis Dowson <elvis.dowson@mac.com> writes:
>>
>>> When you say rebase to 2.6.30, where would I get this updated kernel
>>> branch from? Can you tell me the git repository location, please?
>>
>> When I rebase the PM branch, it will still be called 'pm' and will be
>> remain in my linux-omap-pm git tree[1].
>>
>> The current 2.6.29-based pm branch will be renamed pm-2.6.29 for those
>> wanting to keep using a 2.6.29-based version.
>>
>> Kevin
>>
>> [1] 
>> http://git.kernel.org/?p=linux/kernel/git/khilman/linux-omap-pm.git;a=summary 
>>
>
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

