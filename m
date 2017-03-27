From: Shuah Khan <shuahkh@osg.samsung.com>
Subject: Re: [PATCH 0/7] dwc3 - bug fixes and use meaningful goto labels
Date: Mon, 27 Mar 2017 07:44:26 -0600
Message-ID: <8477b3ae-7841-db0b-1faa-7c0dfa452082@osg.samsung.com>
References: <cover.1490387086.git.shuahkh@osg.samsung.com>
 <87poh523r3.fsf@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <87poh523r3.fsf@linux.intel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Felipe Balbi <balbi@kernel.org>, gregkh@linuxfoundation.org, kgene@kernel.org, krzk@kernel.org, javier@osg.samsung.com
Cc: linux-samsung-soc@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, Shuah Khan <shuahkh@osg.samsung.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 03/25/2017 01:51 AM, Felipe Balbi wrote:
> 
> Hi,
> 
> Shuah Khan <shuahkh@osg.samsung.com> writes:
>> This patch series consists of two fixes and changes to goto labels
> 
> we *NEVER* put cleanups and fixes together.
> 
>> to use meaningful names.
>>
>> While working on goto label changes, I noticed  put_sync calls without
>> successful get_sync in error legs.  The first two patches are the fixes
>> and the rest of the patches are goto label changes.
> 
> so, you mean to say that you're adding regressions because you *THOUGHT*
> there was a bug there, right? Read the docs ;-)
> 

Sorry for the noise. Thanks for pointing this out.

-- Shuah
